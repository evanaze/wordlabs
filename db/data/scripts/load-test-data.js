const { MongoClient } = require("mongodb");
const uri = "mongodb+srv://admin:admin@localhost:27017";
const test = require('../files/test.html')

const client = new MongoClient(uri);
async function run() {
    try {
        await client.connect();
        // database and collection code goes here
        // insert code goes here
        // display the results of your operation
    } finally {
        // Ensures that the client will close when you finish/error
        await client.close();
    }
}
run().catch(console.dir);