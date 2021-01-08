import React from "react";
import ReactDOM from "react-dom";
import redaxios from "redaxios";
import { ChakraProvider } from "@chakra-ui/react";

import App from "root/components/App";

import "normalize.css";
import "./styles/base.css";

window.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(
    <ChakraProvider>
      <App />
    </ChakraProvider>,
    document.getElementById("root")
  );
});

// @ts-ignore
if (import.meta.env.MODE === "development") {
  redaxios.defaults.baseURL = "http://localhost:4000";
}
