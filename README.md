# coligo-action
An action to deploy containers to IBM Cloud Knative

## Inputs

### `project`

**Required** The name of the project to deploy. Default `"World"`.

## Outputs

### `time`

The time we greeted you.

## Example usage

uses: actions/coligo-action@v1
with:
  project: 'awethum project'
