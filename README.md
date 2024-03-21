# Setup instructions

## Working on a B117 machine
Simply start the notebook using:
```
.\StartNotebook.ps1
```

## Working on your own machine
You need to set up everything manually.

### Set up a virtual environment
On Linux (Bash) or MacOS (Zsh):
```
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```

On Windows (PowerShell):
```
py -m venv env
.\env\Scripts\activate.ps1
pip install -r requirements.txt
```

### Install jupyter extensions
```shell
jupyter contrib nbextension install --sys-prefix
jupyter nbextension enable contrib_nbextensions_help_item/main
jupyter nbextension enable hide_input/main
jupyter nbextension enable exercise/main
jupyter nbextension enable exercise2/main
jupyter nbextension enable collapsible_headings/main
jupyter nbextension enable init_cell/main
```

### Open the notebook
To open the Jupyter notebook, run:
```
jupyter notebook
```

### Deactivate virtual environment
After the seminar, deactivate the virtual environment:
```
deactivate
```