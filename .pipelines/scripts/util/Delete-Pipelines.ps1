param(
    $PrefixString
)

$buildAndDeployPipelineName = "${PrefixString}-ApiOps-BuildAndDeploy"
$extractorPipelineName = "${PrefixString}-ApiOps-Extractor"
$publisherPipelineName = "${PrefixString}-ApiOps-Publisher"

# For each of the variables above, use the command 'az pipelines delete' to delete
az pipelines delete --name $buildAndDeployPipelineName --yes
az pipelines delete --name $extractorPipelineName --yes
az pipelines delete --name $publisherPipelineName --yes

