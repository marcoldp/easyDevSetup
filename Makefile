SHELL=/bin/bash   # This is the standard compliant method
.SILENT: # To not display the bash output 

# Reads all the folders name on the select folder and iterates through each one to create a target for each
# Rewrites the targets with each make or make help under the tags AUTO-GENERATED
# TO THINK: How to create for more then one folder
#			define variables for tags, commands
define dinamic_targets
	sed -i "" "/^################## AUTO-GENERATED ####################$$/,/^############### END AUTO-GENERATED ###################$$/d" Makefile ; 
	echo "################## AUTO-GENERATED ####################" >> Makefile;  
	
	folder=$(1); \
	arrFolder=(`cd $${folder}; ls -d */`); \
	for ((i=0; i<$${#arrFolder[@]}; i++)); \
	do \
 		echo -e "\n.PHONY: $${arrFolder[$$i]%"/"} \n$${arrFolder[$$i]%"/"}: ## HELP TO COMMAND\n	##Here Code..." >> Makefile; \
	done; 
	
	echo "############### END AUTO-GENERATED ###################\n" >> Makefile;
endef

.PHONY: help
help: 
	$(call dinamic_targets,"DIRECTORY/") 
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
