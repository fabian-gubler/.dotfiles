# Python Development Enviroment Template

This builds a very minimal FHS (Filesystem Hiearchy Standard) system for python packages managed by conda (placed in ~/.conda).

## Build Conda
```
# Run Environment
nix-shell 

# Install packages
conda install <pkg>
```

## Create Environments
```bash
# Create virtualenv with deps
conda create -n venv ipython numpy

# Activate environment
source activate venv
```


## TODO
- List python packages (requirements.txt with conda command?)
- Check, whether no redundancy when multiple envs has same package
- Automatically create virtual environment
- Automatically activate said virtual environment

## Resources & Explanations
- [Conda on Nix with FHS](http://www.jaakkoluttinen.fi/blog/conda-on-nixos/)
- [Context: FHS Blogpost](https://sandervanderburg.blogspot.com/2013/09/composing-fhs-compatible-chroot.html)
- [Extended](https://github.com/olynch/scientific-fhs)
- [FHS Docs](https://ryantm.github.io/nixpkgs/builders/special/fhs-environments/)
