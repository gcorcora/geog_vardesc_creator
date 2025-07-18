## NOTE: This README is part of a broader pipeline, which I did not create, the README references part of that pipeline.

# DHS Geography Variable Description Creator

This scripts creates single-sample geography variable descriptions for DHS using a user-provided list of samples.

## Folder is `geogRepo/GlobalHealth/descriptionCreator/`

Currently, the bash script (run_geog_vardesc.sh) calls a list of samples from /pkg/ipums/dhs/variables/geography/templates/vardescs_to_generate.txt. 
I have commented out code to faciliate the change to a different location within the Repo, specifically, geogRepo/GlobalHealth/descriptionCreator/inputs/vardescs_to_generate.txt.
To create this, one would need to create the inputs subfolder and generate a .txt file within it if this functionality is preferred.

## Scripts

- `run_geog_vardesc.sh`: Bash script that activates the conda environment and runs the python script
- `geog_vardesc_creator.py`: Main python script generating variable descriptions

## Requirements

- Shell script requires conda environment `var_desc_geog`, which is owned by Gretchen Corcoran (gcorcora) and has necessary libraries loaded. If one needs to be created in future, libraries used included docx, argparse, os, sys, traceback, pandas, re, textwrap. May also need to load openpyxl depending on the pandas version.
- Python 3.x required

## Usage

From repo root, run:

```bash
./GlobalHealth/descriptionCreator/run_geog_vardesc.sh
```

The script can also be ran with a custom sample list file location

```bash
./GlobalHealth/descriptionCreator/run_geog_vardesc.sh --sample_list /path/to/your/list.txt
```

## Output

Output currently writes to /pkg/ipums/dhs/variables/geography/templates/autogenerated_vardescs and need to be moved to the appropriate DHS geography variable folder after researcher review.

## Future Improvements

1. Remove need for manual list - have the script check variables.xlsx for geography variables, and if a variable description is missing for that variable in the appropriate folder, create the vardesc and provide a report of new vardescs created.
2. Functionality for multiple sample variables and _alt geography variable descriptions


