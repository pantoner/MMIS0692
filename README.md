I'll analyze the MMIS0692 repository and create a well-structured README file that includes:

- **Project title & description**
- **Key features**
- **Installation & setup instructions**
- **Usage details**
- **Tech stack**
- **License & contribution guidelines** (if applicable)

Let me review the repository and generate the README.

# Business Intelligence Capstone – Production Planning Optimization

This project is a capstone for a Business Intelligence (BI) course (MMIS 0692) focused on analyzing production data and optimizing manufacturing plans. It provides a comprehensive analysis of production costs and capacities for multiple products and uses statistical modeling and linear programming to minimize production costs while meeting demand. The goal is to demonstrate BI analytics skills by cleaning data, performing exploratory analysis, forecasting or analyzing demand, and formulating an optimization model to support decision making.

## Key Features

- **Data Import & Cleaning**: Automatically fetches production and demand datasets from an AWS S3 bucket. The code cleans and preprocesses the data (e.g. removing currency symbols and converting data types) to prepare for analysis.  
- **Exploratory Analysis**: Provides summaries of key metrics (machine time, assembly time, finish time, cost) for each product type. This helps in understanding production characteristics and identifying trends or outliers in the data.  
- **Cost Modeling**: Implements a multiple linear regression to explore how various factors (product type and production times) influence production cost. The statistical output (coefficients, confidence intervals) offers insights into cost drivers.  
- **Optimization (Linear Programming)**: Formulates a linear programming model using the `lpSolve` library to determine the optimal production mix. The model incorporates constraints (machine hours, assembly hours, finishing hours, and product demand) and an objective to minimize total production cost by deciding how many units to produce on regular vs. special runs for each product.  
- **Reproducible Analysis**: Includes an R Markdown report (`PreliminaryReport2.rm`) that combines narrative, code, and output. This report can be knitted to produce a formatted document (HTML or PDF) showing the analysis steps and results in a reader-friendly way.

## Installation & Setup

1. **Clone the Repository**: Download the project source code by running:  
   ```bash
   git clone https://github.com/pantoner/MMIS0692.git
   ```  
   Alternatively, use GitHub Desktop or download the ZIP from the GitHub page and extract it.

2. **Install R**: Ensure you have R installed on your system (the project was developed and tested with R, version 4.x is recommended). For an easier experience, installing RStudio is encouraged but not required.

3. **Install Required Packages**: Open R/RStudio and install the necessary R packages. The main libraries used are **httr**, **stringr**, **plyr** (for data manipulation using `ddply`), and the linear programming packages **lpSolve** and **lpSolveAPI**. You can install them by running in R:  
   ```r
   install.packages(c("httr", "stringr", "plyr", "lpSolve", "lpSolveAPI"))
   ```  
   (You might already have some of these packages. If using RStudio, you can also install packages via Tools → Install Packages.)

4. **Set Working Directory**: In R or RStudio, set your working directory to the cloned project folder. For example, in R:  
   ```r
   setwd("path/to/MMIS0692")
   ```  
   This ensures the scripts can find any files if needed (though in this project, data is fetched from the web).

5. **Open the Project Files**: The key files in this repository are:  
   - `Demand.R`: A script to load and inspect the demand data.  
   - `PreliminaryReport.R`: An R script performing initial data analysis, regression, and a sample optimization.  
   - `PreliminaryReport2.rm`: An R Markdown file containing the refined analysis and report. (You can open this in RStudio for an interactive report environment.)

## Usage

**Running the Analysis Scripts**: You can run the R scripts directly to execute the analysis. For example:  

- In R console or RStudio, run `source("PreliminaryReport.R")`. This will:  
  - Fetch the production data and demand data from S3.  
  - Clean and preprocess the data (convert types, remove symbols).  
  - Perform a linear regression and print the model summary and coefficients in the console.  
  - Set up the linear programming model and solve it, outputting the optimal values and objective cost in the console.  

- To examine the demand data on its own, run `source("Demand.R")`. This will load the demand dataset and print the column names or basic info, which you can then explore or use in other calculations.

**Using the R Markdown Report**: For a more narrative approach, open `PreliminaryReport2.rm` in RStudio (or rename it to `PreliminaryReport2.Rmd` if needed for recognition). Then click the "Knit" button (or use `rmarkdown::render("PreliminaryReport2.rm")` in R) to generate a formatted report (HTML or PDF). The R Markdown will execute the code chunks and include outputs such as summary tables or plots (if any were included) along with explanations. This is useful to review the analysis step-by-step with commentary.

**Interacting with the Results**: The analysis primarily prints results to the console or includes them in the knitted report. For example, after running the optimization, the solution (optimal production quantities for each product and run type) is displayed. You can modify parameters (like demand values or cost coefficients) in the script and re-run it to see how the outcome changes, making it a useful tool for what-if analysis.

**Note**: The data is fetched from a public AWS S3 bucket each time you run the scripts. Ensure you have an active internet connection when running the code so that R can download the CSV files. If you prefer to work offline, you can manually download `production.csv` and `demand.csv` from the S3 links and adjust the code to read from local files.

## Tech Stack

- **Programming Language**: R – The project is written entirely in R, leveraging its rich ecosystem for statistical analysis and optimization.  
- **Data Retrieval**: **HTTR** library – Used to perform HTTP GET requests to download CSV data from an AWS S3 bucket. This allows the latest data to be pulled directly when running the scripts.  
- **Data Processing**: Base R and **stringr** for data cleaning (e.g., removing symbols from strings), and **plyr** for data aggregation (`ddply` is used to compute mean values by product category). These tools handle tasks like converting data types and summarizing data.  
- **Statistical Modeling**: Built-in R **stats** functions – A multiple linear regression model (`lm`) is used to understand cost drivers. The summary of this model provides insights such as coefficients and significance of predictors.  
- **Optimization Framework**: **lpSolve** and **lpSolveAPI** – R packages that provide functions for formulating and solving linear programming problems. They are used to create a linear program for production planning, define constraints (capacities and demand), and solve for the cost-minimizing production plan.  
- **Reporting**: **R Markdown** – The analysis is documented in an R Markdown file, which integrates code and narrative. Knitting this file produces a human-readable report, which is an important part of the BI capstone to communicate findings.  
- **Version Control**: Git and GitHub – The project is hosted on GitHub for version control, collaboration, and transparency of development.

## Configuration & Environment Variables

This project does not require special configuration or external environment variables. All important parameters (like data source URLs and model parameters) are defined within the R scripts. To run the analysis, you simply need the R environment set up with the required packages (as described above) and internet access for data retrieval.

**Data Source Config**: The URLs for the datasets (`production.csv` and `demand.csv`) are hard-coded in the scripts. If these files move or if you want to use local data, you might need to update the `GET("https://s3.amazonaws.com/ACEO/…")` calls in the code to point to the new location or local file path.

**Runtime Environment**: The code should run on any OS (Windows, macOS, Linux) that supports R. No additional environment setup is needed beyond installing packages. All computations are done in-memory; ensure your system has enough memory for the data size (the provided data files are presumed to be reasonably small as typical for a course project).

## Contributing

Contributions are welcome to improve this project! Since this was initially developed as an academic capstone, you might have ideas to extend its functionality or enhance its analysis. To contribute:

1. **Fork the Repository**: Click the "Fork" button on GitHub to create your own copy of the project.
2. **Create a Branch**: In your fork, create a new branch for your feature or bug fix (e.g., `feature/improve-optimization` or `bugfix/data-import-issue`).
3. **Make Changes**: Implement your changes in the R scripts or add new files. Ensure that your code is well-documented and follows a similar style to the existing code for consistency.
4. **Test**: Run the scripts after your changes to make sure everything works as expected and the analysis results remain valid.
5. **Commit**: Commit your changes with clear and descriptive commit messages explaining the what and why of the modifications.
6. **Push & Submit a PR**: Push your branch to your GitHub fork and open a Pull Request to the main repository. In the PR description, detail the changes and any new features so the maintainers can understand and review your contribution.

Before contributing, it’s a good idea to open an issue for discussion if you plan a significant change. This allows alignment on the approach and design. All contributions should aim to enhance the project’s educational value and maintain clarity and reproducibility of the analysis.

## License

**No explicit license** is provided for this project. Since it was created as part of a university course, it is not currently released under an open-source license. All rights to the source code and content are reserved by the author. 

If you wish to use any part of this project outside of personal or educational purposes, please contact the repository owner for permission. In the future, the author may choose to add an open-source license to make contributions and usage easier. Until then, kindly respect that this code is provided mainly for learning and demonstration.
