import React from 'react';
import { BrowserRouter } from 'react-router-dom';

import AppRouter from "./router/router";
import WebHeader from "./components/header";
import WebFooter from "./components/footer";

/**
 *  入口组件
 */
function App() {
  return (
      <BrowserRouter>
          <WebHeader/>
          <AppRouter/>
          <WebFooter/>
      </BrowserRouter>
  );
}

export default App;
