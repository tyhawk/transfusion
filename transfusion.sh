#!/bin/bash
#############################################################################
# TransFusion - the One-Stop TV Show & Movie File Preparer & Uploader
#             (not named OSTVSMFPU because mediaprep is easier to remember)
# © 2014 John Gerritse
#
# Create a fully transcoded MKV file of TV episodes & Movies in one script
#############################################################################
# Ideas (remove this later)
# - Script creates job files through user interaction
# - Script processes job files without user interaction
#
# TODO LOCKFILE mechanism to prevent 2 instances from running jobs.
#               Creating jobs is allowed when an instance is already running.
#############################################################################

# Know thyself
PROGNAME=$(basename $0)

# Check in which directory I am installed
mydir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Not sure what would be a nice place to stick the conf file yet
# For now, I will leave it in the same dir as the script
mediaprepconf="$mydir/mediaprep.conf"

# Same for the logfile. Let's stick that into the same directory for now.
mediapreplog="$mydir/mediaprep.log"

#####
# Load general functions
#####
source functions/general_*.func

do_error() {
  printf "[${red}ERR${normal}]\n"
  breakloop="YES"
}

#####
# Menu functions
#####
menulogo() {
	# Clear screen en print 'logo'
	clear
	printf "${blue}${bright}#     #                                 ######\n"
	printf "##   ##  ######  #####      #      ##   #     #  #####   ######  #####\n"
	printf "# # # #  #       #    #     #     #  #  #     #  #    #  #       #    #\n"
	printf "#  #  #  #####   #    #     #    #    # ######   #    #  #####   #    #\n"
	printf "#     #  #       #    #     #    ###### #        #####   #       #####\n"
	printf "#     #  #       #    #     #    #    # #        #   #   #       #\n"
	printf "#     #  ######  #####      #    #    # #        #    #  ######  #\n"
	printf "\n         Create transcoded MKVs from raw video files${normal}\n\n"
}

#####
# Job file functions
#####
create_jobs() {
	# All functions needed to create jobs go here
}


#####
# Processing functions
#####
process_jobs() {
	# All functions to process jobs go here
	count_jobs
}
count_jobs() {
	jobcount=$(ls $queuedir/*.job)
	if [[ "$jobcount" -eq 0 ]]; then
		message="No jobs in the queue found."; type="err"; stop="yes"
		return_output
	fi
}


#####
# Misc functions
#####
sourceconfig() {
	# Source the config file
	source $mediaprepconf
}

#####
# The script itself
#####

# Trap TERM, HUP, and INT signals and properly exit
trap exit_term TERM HUP
trap exit_int INT

# Dependency check
check_dependency
check_directory

# Process depending on options
while getopts "bjh" opt; do
    case $opt in
        b  )  output="no"; process_jobs; exit 0 ;;
        j  )  output="yes"; create_jobs; exit 0 ;;
        h  )  usage; exit 0 ;;
        *  )  printf "Unimplimented option: -$OPTARG" >&2; exit 1;;
    esac
done

# Start of interactive section of the script
output="yes"
menulogo


#####
# END
#####
