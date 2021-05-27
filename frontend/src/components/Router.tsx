import React from "react";
import { Switch, Route, RouteProps } from "react-router-dom";
import loadable from "@loadable/component";

type AsyncRouteProps = RouteProps & { importPath: () => Promise<any> };

function AsyncRoute({ importPath, ...props }: AsyncRouteProps) {
  return <Route {...props} component={loadable(importPath)} />;
}

export default function Router(): JSX.Element {
  return (
    <Switch>
      <AsyncRoute
        exact
        path="/"
        importPath={() => import("root/pages/HomePage")}
      />
      <AsyncRoute
        exact
        path="/rooms"
        importPath={() => import("root/pages/Room")}
      />
    </Switch>
  );
}
