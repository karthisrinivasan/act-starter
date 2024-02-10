# act-starter

Skeleton repository for ACT projects.

## Organizing ACT Files

- Typically, different classes of processes should exist in their own namespaces, defined within their own folders.
- See `module1` for a simple example.
- The top-level design should be in `src` and import all the modules/sub-processes it needs from the correct namespace.

## Generating Tests

- See `test` for folder structure.
- Each folder in `test` contains one test case.
- These folder names can be arbitrary.
- The act file for testing needs to be named `test.act`.
- The process for testing needs to be named `test`.
- The actsim input script needs to be named `test.actsim`.
- To write a test, either use the verification functionality included in actsim's `sim` library, or use `make regression` to generate a regression test reference output. You can find examples for both in this repository.
- If actsim exits with no errors while generating regression test reference output, the output from actsim will be saved as `test.truth`, which is assumed to be the correct output for further tests.
- You need to commit all of these files to git if you want the tests to work. All output files generated during the test procedure which do not need to find their way into git have already been put into the `.gitignore` for your convenience.

## Running Tests

- Run `make runtest` or simply `make` to run through all test cases.

## Cleaning Test Folders

- Run `make cleantest` to delete the generated files from running the test cases.

## Accessing ACT Files

- To access the namespaces defined in `src` from elsewhere, add the path to the `src` folder to your `ACT_PATH`. You can do that by calling `source env_setup.sh`
