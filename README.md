# coligo-action
An action to deploy containers to IBM Cloud Knative

## Inputs

All imputs are environment variables

### `PROJECT`

**Required** The name of the coligo project to target.

Run the following to find available projects.
```
$ ibmcloud coligo project list
```
See https://cloud.ibm.com/docs/knative?topic=knative-manage-project

### `IBMCLOUD_API_KEY`

**Required** Key for IBM API.
To generate run the following command:
```
$ ibmcloud iam api-key-create nodejs-coligo-sample
```

### `REGISTRY`

**Required** Container Registry to store the generated container.
```
quay.io
docker.io
cr.io
```

### `REGISTRY_USERNAME`

**Required** Container Registry User Name.


### `REGISTRY_API_KEY`

**Required** Container Registry Access Token.
```

```
## Outputs

### `time`

The time we greeted you.

## Example usage

```
on: [push]

jobs:
  coligo_job:
    runs-on: ubuntu-latest
    name: build and deploy coligo service
    steps:
    - name: build and deploy 
      id: coligo
      uses: no9/coligo-action@1.8.0
      env:
        PROJECT: 'sample-app'
        IBMCLOUD_API_KEY: ${{ secrets.IBMCLOUD_API_KEY }}
        REGISTRY: 'docker.io'
        REGISTRY_USERNAME: 'number9'
        REGISTRY_API_KEY: ${{ secrets.DOCKER_API_KEY }}
    - name: Get the output time
      run: echo "The time was ${{ steps.coligo.outputs.time }}"
```
