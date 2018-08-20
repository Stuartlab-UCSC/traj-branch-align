# traj-branch-align
Python and R code facilitating the alignment of trajectories using a combination of determined marker genes, pseudotime assignment from a trajectory inference method, and dynamic time warping.

To use clone the repo to `some/dir`, for an R utility use `source(some/dir/traj-branch-align/src/R/r_util_of_interest.r)` in your R environment. For a python utility add `some/dir/traj-branch-align/src/python` to your $PYTHONPATH. Make sure the dependencies for the particular utility (listed below) are installed.

## dependencies
R - branch\_gene\_markers.r
    `install.packages("gam")`
