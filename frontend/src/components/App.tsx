import React from "react";
import { Box } from "@chakra-ui/react";
import { BrowserRouter } from "react-router-dom";
import { AuthProvider } from "root/hooks/useAuth";
import Router from "./Router";

export default function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <Box p={{ base: "2rem", md: "2rem" }}>
          <Router />
        </Box>
      </AuthProvider>
    </BrowserRouter>
  );
}
