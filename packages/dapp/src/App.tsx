import { FC } from "react";

import { Route, Routes } from "react-router-dom";

import { Provider, createClient } from "wagmi";
import { InjectedConnector } from "wagmi/connectors/injected";
import { chains } from "./utils/web3";

import { ThemeProvider } from "degen";
import "degen/styles";

import { ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

import Home from "./pages/Home";
import Layout from "./components/layout";

import "./index.css";

const client = createClient({
  autoConnect: true,
  connectors() {
    return [
      new InjectedConnector({
        chains,
      }),
    ];
  },
});

const App: FC = () => {
  return (
    <Provider client={client}>
      <ThemeProvider>
        <Layout>
          <Routes>
            <Route path="/" element={<Home />} />
          </Routes>
        </Layout>
      </ThemeProvider>
      <ToastContainer />
    </Provider>
  );
};

export default App;
