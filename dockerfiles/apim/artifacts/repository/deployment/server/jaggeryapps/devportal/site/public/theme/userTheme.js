const Configurations = {
    /*
     This file can be used to override the configurations in devportal/source/src/defaultTheme.js
     ex. Uncomment the below section to enable the landingPage
     */
    /*
    custom: {
        landingPage: {
            active: true,
        },
    },
    */
    palette: {
        primary: {
            // light: will be calculated from palette.primary.main,
            main: '#cd5f00',
            light: "rgb(71, 145, 219)",
            dark: "rgb(17, 82, 147)",
            contrastText: "#fff",
            // dark: will be calculated from palette.primary.main,
            // contrastText: will be calculated to contrast with palette.primary.main
        },
        text: {
            primary: "#2d3748",
            secondary: "#718096",
        },
    },
    custom: {
        appBar: {
            logo: '/site/public/custom/logo.svg', // You can set the url to an external image also ( ex: https://dummyimage.com/208x19/66aad1/ffffff&text=testlogo)
            background: '#65a1bd',
            activeBackground: '#0000004d',
        },
        "page": {
            "style": "fluid",
            "emptyAreadBackground": "#b2d8d6d1"
        },
    }
};