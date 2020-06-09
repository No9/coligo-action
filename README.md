# coligo-action
An action to deploy containers to IBM Cloud Knative

## Inputs

### `project`

**Required** The name of the project to deploy. Default `"World"`.

### `ibmapikey`

**Required** Key for IBM API. Default `""`.

### `registryusername`

**Required** Container Registry User Name. Default `""`.

### `registryaccesstoken`

**Required** Container Registry Access Token. Default `""`.

## Outputs

### `time`

The time we greeted you.

## Example usage

uses: no9/coligo-action@1.0.0
with:
  project: 'awethum project'
