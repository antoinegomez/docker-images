const volumes = [
  {
      "name": process.env.ECS_VOLUME_NAME,
      "host": {}
  }
];

console.log(JSON.stringify(volumes, null, 2));
