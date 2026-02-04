📊 Statistical Ranking of Algorithms (SRA)

Paper Title:
Nuanced Algorithm Selection: A Comprehensive Comparative Study of Evolutionary, Swarm Intelligence, and Physics/Mathematics-Based Optimization Algorithms

Authors:
Najibeh Farzi-Veijouyeh, Mohammad-Reza Feizi-Derakhshi

Cite this article:

Farzi-Veijouyeh, N., Feizi-Derakhshi, MR. A Comprehensive Comparative Study of Evolutionary, Swarm Intelligence, and Physics/Mathematics-Based Optimization Algorithms by the Novel SRA Algorithm. Arch Computat Methods Eng (2026). https://doi.org/10.1007/s11831-025-10472-9

📘 Overview

This repository contains the MATLAB implementation of the Statistical Ranking of Algorithms (SRA) method proposed in the paper.

The SRA method was designed to overcome the limitations of the widely used Friedman test, which may overlook subtle differences among multiple independent runs.
SRA provides a more nuanced, bias-reduced, and statistically robust approach for comparing optimization algorithms across multiple criteria and function groups.

🚀 Key Features

Comprehensive Statistical Ranking: Incorporates all runs instead of relying on averaged performance only.

Weighted Multi-Criteria Evaluation: Allows adjustable weights (Beta) for each criterion or function group.

Flexible Group Analysis: Supports both intra-category and inter-category comparisons among algorithms.

Wide Applicability: Can be applied in optimization, data science, engineering, and social science domains — provided the results are quantitative or ordinal.

Transparent and Reproducible: Designed for full reproducibility of comparative analysis in research studies.

🧩 File Structure
📂 SRA
├── SRA.m                    # Main function implementing the Statistical Ranking Algorithm
├── Example_SRA.m            # Example script showing how to use SRA with benchmark data
├── ResultsOA.mat            # Example data file (FbestMAT, algorithm names, function names)
├── README.md                # This documentation file
└── /Figures (optional)      # Folder for generated plots (if applicable)

⚙️ How to Use

Load your performance data
The .mat file must contain:

FbestMAT → Performance matrix (Algorithms × Functions × Runs)

NamesofAlgorithms → Cell array of algorithm names

NamesofFunctions → Cell array of test function names

Set parameters in the example file:

alpha = 0.05;                       % Significance level
Algorithms = 1:12;                  % Indices of algorithms to include
Functions = 1:29;                   % Indices of functions to include
Beta = [0.2, 0.3, 0.5];             % Group weights (must sum to 1)
FunctionGroup = [ones(1,7), 2*ones(1,16), 3*ones(1,6)]; % Function group assignment


Run the example script

run('Example_SRA.m');


View the results
The output includes:

FailureRate → Percentage of failed comparisons per algorithm

Rank_ID → Final SRA-based ranking index

ResultsTable → A MATLAB table summarizing algorithm performance rankings

🧠 Methodological Insight

Unlike conventional ranking methods such as the Friedman test, the SRA method:

Considers all independent runs for each algorithm–function pair.

Reduces ranking bias caused by averaging.

Provides an adjustable, multi-criteria, and group-aware statistical evaluation framework.

This makes it particularly suitable for metaheuristic optimization algorithm benchmarking and comparative meta-analysis.

📂 Example

An example configuration compares 12 algorithms on 29 test functions grouped into:

Group 1: Unimodal functions (F1–F7) → weight = 0.2

Group 2: Multimodal functions (F8–F23) → weight = 0.3

Group 3: Composite functions (F24–F29) → weight = 0.5

The script outputs a ranked list of algorithms with statistical significance testing.

📈 Citation

If you use this code or method in your research, please cite:

Najibeh Farzi-Veijouyeh, Mohammad-Reza Feizi-Derakhshi.
Nuanced Algorithm Selection: A Comprehensive Comparative Study of Evolutionary, Swarm Intelligence, and Physics/Mathematics-Based Optimization Algorithms.
Archives of Computational Methods in Engineering, 2025.
DOI: [To be assigned]

📧 Contact

For questions or collaboration inquiries:
📩 Najibeh Farzi-Veijouyeh
📧 Email: [najibeh.farzi@gmail.com
]
