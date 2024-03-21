# This is a PowerShell script that will open up Jupyter notebook using
# the single read-only virtual.
#
# This should work on the faculty machines 'dryadaXX' and possibly on other.
# This might also work on students' machines.

function InstallJupyterExtensions() {

	jupyter contrib nbextension install --sys-prefix
	jupyter nbextension enable contrib_nbextensions_help_item/main
	jupyter nbextension enable hide_input/main
	jupyter nbextension enable exercise/main
	jupyter nbextension enable exercise2/main
	jupyter nbextension enable collapsible_headings/main
	jupyter nbextension enable init_cell/main
}

function StartNotebook() {
	Write-Host "[INFO] Starting Jupyter Notebook"
	# start the notebook
	jupyter notebook
}

function ActivateVirtual() {
	py -m venv env
	.\env\scripts\activate.ps1
}

function InstallRequirements() {
	pip install --upgrade pip
	pip install wheel
	pip install --requirement .\requirements.txt
}

function IsInsideVirtual() {
	# We want to check for env var VIRTUAL_ENV and the existence of deactivate cmdlet
	if (( (Test-Path env:VIRTUAL_ENV)) -and (Get-Command deactivate --errorAction SilentlyContinue))  {
		return $true
	}
	return $false
}

function Main() {
	Write-Host "[INFO] Preparing to start the Jupyter Notebook"
	try {
		$at_fi = [System.DirectoryServices.ActiveDirectory.Domain]::GetComputerDomain().Name
	} catch {
		$at_fi = ""
	}
	if ($at_fi.Equals("ad.fi.muni.cz")) {
		# deactivate if we are in another virtual already
		if (IsInsideVirtual) {
			Write-Host "[INFO] VIRTUAL_ENV before deactivation: $env:VIRTUAL_ENV"
			deactivate
			Write-Host "[INFO] VIRTUAL_ENV after deactivation: $env:VIRTUAL_ENV"
		} else {
			Write-Host "[INFO] Executed not from a virtual environment"
		}
		# activate the virtual environment
		i:\pv080\seminars\venv\scripts\activate.ps1
		Write-Host "[INFO] Using VIRTUAL_ENV: $env:VIRTUAL_ENV"
	} else {
		ActivateVirtual
		InstallRequirements
	}
	InstallJupyterExtensions

	StartNotebook
}

Main
