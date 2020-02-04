const fs = require('fs');
const path = require('path');

const taskName = process.env.ECS_TASK_DEFINITION_NAME;
const newImage = [process.env.ECR_URI, process.env.VERSION].join(':');
const envFilePath = process.env.ENV_FILE_PATH;
const awsEnv = process.env.AWS_ENV;
const filename = path.join(__dirname, '.task.json');

function updateEnvVariable(entry, key, value, upsert = false) {
    const envFileVariable = entry.find(item => item.name == key);

    if (envFileVariable) {
        envFileVariable.value = value;
    } else if (upsert) {
        entry.push({
           name: key,
            value,
        });
    }
}

try {
    const fileContent = fs.readFileSync(filename).toString();
    const taskDefinition = JSON.parse(fileContent);
    const task = taskDefinition.taskDefinition.containerDefinitions.find(definition => definition.name == taskName);

    task.image = newImage;
    updateEnvVariable(task.environment, 'ENV_FILE_PATH', envFilePath);
    updateEnvVariable(task.environment, 'AWS_ENV', awsEnv, true);

    taskDefinition.taskDefinition.containerDefinitions.reverse();

    console.log(JSON.stringify(taskDefinition.taskDefinition.containerDefinitions));
} catch (err) {
    console.log(err.stack);
    process.exit(1);
}
