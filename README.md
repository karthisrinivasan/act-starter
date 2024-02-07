# act-starter
 Skeleton repository for ACT projects. 

Setup: 
- Export ACT_PATH to point to the src folder.
- `export ACT_PATH=$(pwd)/src:$ACT_PATH` if you're in the folder where this README is located.

Generating Tests:
- See `test` for folder structure. 
- Each folder in `test` contains one test case. 
- These folder names can be anything.
- The actfile for testing needs to be named `test.act`.
- The process for testing needs to be named `test`.
- The actsim input script needs to be named `test.actsim`.
- Once a new test is set up this way, run `./testgen.sh` and input the folder name.
- If actsim exits with no errors, the output from actsim will be saved as `test.truth`, which is assumed to be the correct output.

Running Tests:
- Run `make runtest` or simply `make` to run through all test cases.