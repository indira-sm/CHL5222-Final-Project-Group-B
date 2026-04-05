# Factors Associated with Ambulance Diversion Hours: An Analysis of California Hospitals (2013–2015)

This repository contains the files used to complete the analysis and report for this project.

## File Structure

- `data/` contains the raw and processed data used in this analysis.
- `figures/` contains figures used in the preliminary analysis and final report.
- `models/` contains model files used in the preliminary analysis and final report.
- `report/` contains the final report in `.pdf` and `.qmd` formats as well as the `.bib` file used to produce the references list.
- `scripts/` contains the `R` scripts used in this analysis.
- `tables/` contains the model results in `.rds` format.
- `tibbles/` contains tibbles used in the preliminary analysis.
- `values/` contains numerical values used in the preliminary analysis and final report.

## Reproduction of Analysis

To reproduce this analysis, complete the following steps:

1. Install Git, `R`, and RStudio on your computer if they are not already installed.
2. Open RStudio on your computer.
3. Navigate to File --> New Project --> Version Control --> Git.
4. Under "Repository URL", paste this link: https://github.com/indira-sm/CHL5222-Final-Project-Group-B.git
5. Under "Project directory name", ensure that the following is entered: CHL5222-Final-Project-Group-B
6. Under "Create project as subdirectory of", use the Browse button to select a location on your computer of your choosing.
7. Click on "Create Project".
8. In RStudio, navigate to "Files".
9. Open `main.R`, select all of the code in `main.R`, and click on "Run".

All of the objects used in this analysis should now be in the various folders listed above (`data/`, `figures/`, `models/`, `tables/`, `tibbles/`, and `values/`).

## Reproduction of Report

Afterward, to reproduce the report in `.pdf` format, complete the following steps:

1. In RStudio, navigate to "Files".
2. Open the `report` folder and click on `report.qmd`.
3. In the `report.qmd` file, click on "Render".

The report should now open in your browser in `.pdf` format.