import { Client, QueryResult } from "pg";
import config from "./config";

export function getClient(): Client {
    const client = new Client({
        connectionString: config.POSTGRES_URL
    });
    return client;
}

export async function sql(sql: string, value?: Array<any>): Promise<QueryResult<any>>{
    const client = getClient();
    await client.connect();
    const res = await client.query(sql,value);
    await client.end();
    return res;
} 