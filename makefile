# Specify the main target
TARGET = libgccvb

# Default build type
TYPE = release

LIBGCCVB = $(ENGINE_FOLDER)

# Which directories contain source files
DIRS := $(shell find $(LIBGCCVB)/source -type d -print)
		
# Which libraries are linked
LIBS =
# Dynamic libraries
DLIBS =

# Obligatory headers
ESSENTIALS =  -include $(LIBGCCVB)/source/libgccvb.h

# The next blocks change some variables depending on the build type
ifeq ($(TYPE), debug)
LDPARAM = -fno-builtin -ffreestanding  
CCPARAM = -nodefaultlibs -mv810 -Wall -O0 -Winline $(ESSENTIALS) 
MACROS = __DEBUG
endif

ifeq ($(TYPE), release)
LDPARAM =  
CCPARAM = -nodefaultlibs -mv810 -finline-functions -Wall -O3 -Winline $(ESSENTIALS)
MACROS = NDEBUG
endif

# Add directories to the include and library paths
INCPATH := $(shell find $(LIBGCCVB) -type d -print)

# Which files to add to backups, apart from the source code
EXTRA_FILES = makefile

# The compiler
GCC = v810-gcc
OBJCOPY = v810-objcopy
OBJDUMP = v810-objdump
AR = v810-ar

# Where to store object and dependancy files.
STORE = .make-$(TYPE)

# Makes a list of the source (.c) files.
SOURCE := $(foreach DIR,$(DIRS),$(wildcard $(DIR)/*.c))

# List of header files.
HEADERS := $(foreach DIR,$(DIRS),$(wildcard $(DIR)/*.h))

# Makes a list of the object files that will have to be created.
OBJECTS := $(addprefix $(STORE)/, $(SOURCE:.c=.o))

# Same for the .d (dependancy) files.
DFILES := $(addprefix $(STORE)/,$(SOURCE:.c=.d))

# Specify phony rules. These are rules that are not real files.
.PHONY: clean backup dirs

# Main target. The @ in front of a command prevents make from displaying
# it to the standard output.

all: $(TARGET).a

$(TARGET).a: dirs $(OBJECTS)
	@echo Config file: $(CONFIG_FILE)
	@echo Creating $(TARGET).a
	@$(AR) rcs $@ $(OBJECTS) 
	@echo Done $@

# Rule for creating object file and .d file, the sed magic is to add
# the object path at the start of the file because the files gcc
# outputs assume it will be in the same dir as the source file.
$(STORE)/%.o: %.c
	@echo Creating o file for $(TYPE) $*...
	@$(GCC) -Wp,-MD,$(STORE)/$*.dd  $(foreach INC,$(INCPATH),-I$(INC))\
            $(foreach MACRO,$(MACROS),-D$(MACRO)) $(CCPARAM) -c $< -o $@
	@sed -e '1s/^\(.*\)$$/$(subst /,\/,$(dir $@))\1/' $(STORE)/$*.dd > $(STORE)/$*.d
	@rm -f $(STORE)/$*.dd

# Empty rule to prevent problems when a header is deleted.
%.h: ;

# Cleans up the objects, .d files and executables.
clean:
		@echo Making clean.
		@-rm -f $(foreach DIR,$(DIRS),$(STORE)/$(DIR)/*.d $(STORE)/$(DIR)/*.o)
		@-rm -Rf $(STORE)

# Backup the source files.
backup:
		@-if [ ! -e .backup ]; then mkdir .backup; fi;
		@zip .backup/backup_`date +%d-%m-%y_%H.%M`.zip $(SOURCE) $(HEADERS) $(EXTRA_FILES)

# Create necessary directories
dirs:
		@-if [ ! -e $(STORE) ]; then mkdir $(STORE); fi;
		@-$(foreach DIR,$(DIRS), if [ ! -e $(STORE)/$(DIR) ]; \
         then mkdir -p $(STORE)/$(DIR); fi; )

# Includes the .d files so it knows the exact dependencies for every
# source.
-include $(DFILES)
