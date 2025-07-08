#!/bin/bash

##Created by Gretchen Corcoran
#Run by command ./GlobalHealth/descriptionCreator/run_geog_vardesc.sh

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate var_desc_geog

#hard coded script path from previous version, instead now using determine scripts directory then new path
#SCRIPT_PATH="/pkg/ipums/dhs/staff/gretchen_corcoran/python_scripts/geog_vardesc_creator.py"

#determine scripts directory - replace hardcoded path
#Note if there is an error, it could be here this line was taken with chatgpt prior to uploading to github
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

#path to python script
SCRIPT_PATH="${SCRIPT_DIR}/geog_vardesc_creator.py"

#default sample list path - change if want to store elsewhere
#suggestion would be "${SCRIPT_DIR}/inputs/vardescs_to_generate.txt"
#then would need to create subfolder and .txt file in GlobalHealth/descriptionCreator/inputs/vardescs_to_generate.txt
DEFAULT_SAMPLE_LIST="/pkg/ipums/dhs/variables/geography/templates/vardescs_to_generate.txt"

USER_PROVIDED_SAMPLE_LIST=false

#remaining arguments array
REMAINING_ARGS=()

while [[ $# -gt 0 ]]; do 
    case "$1" in 
        --sample_list)
            SAMPLE_LIST="$2"
            USER_PROVIDED_SAMPLE_LIST=true
            shift 2
            ;;
        -h | --help)
            echo ""
            echo "Usage: run_geog_vardesc.sh [--sample_list /path/to/list.txt]"
            echo ""
            echo "Runs geog_vardesc_creator.py using:"
            echo "  default: $DEFAULT_SAMPLE_LIST" 
            echo ""
            echo " This can be overridden with --sample_list /pkg/ipums/other/sample_list.txt to use a different file if desired."
            echo ""
            echo "Examples:"
            echo "  ./GlobalHealth/descriptionCreator/run_geog_vardesc.sh"
            echo "  ./GlobalHealth/descriptionCreator/run_geog_vardesc.sh --sample_list pkg/ipums/custom/folder/list.txt"
            echo ""
            exit 0
            ;;
        *)
            REMAINING_ARGS+=("$1")
            shift
            ;;
    esac
done

#Which sample list in use?
if $USER_PROVIDED_SAMPLE_LIST; then
    LIST_TO_USE="$SAMPLE_LIST"
else
    LIST_TO_USE="$DEFAULT_SAMPLE_LIST"
fi

#Does file exist
if [ ! -f "$LIST_TO_USE" ]; then
    echo "Error - sample list file not found: $LIST_TO_USE"
    exit 1
fi

if [ ! -f "$SCRIPT_PATH" ]; then
    echo "Error - python script not found at $SCRIPT_PATH"
    exit 1
fi

python "$SCRIPT_PATH" --sample_list "$LIST_TO_USE" "${REMAINING_ARGS[@]}"
