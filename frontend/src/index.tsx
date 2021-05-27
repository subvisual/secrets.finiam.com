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

// eslint-disable-next-line @typescript-eslint/ban-ts-comment
// @ts-ignore
redaxios.defaults.baseURL = import.meta.env.SNOWPACK_PUBLIC_API_URL;
