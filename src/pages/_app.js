import React from 'react';

const App = ({
    Component,
    pageProps
}) => {
    return <Component {...pageProps} />
};

App.getInitialProps = async ({ ctx, ...rest }) => {
    return { rest };
};

export default App;
