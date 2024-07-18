import axios from "axios";

const request = axios.create({
    baseURL: 'http://localhost:5104/',
});

export default request;