/** @type {import("tailwindcss").Config} */
module.exports = {
  content: ['./app/**/*.{js,ts,jsx,tsx}'],
  theme: {
    screens: {
      sm: '640px',
      md: '768px',
      lg: '1024px',
      xl: '1280px'
    },
    colors: {
      'glassy-grey': 'rgba(50, 50, 50, 0.7)',
      'green': '#008000',
      'yellow': '#FFFF00',
      'blue': '#0000FF',
      'toxic-green': '#66FF00',
      'purple': '#800080'
    },
    fontFamily: {
      'press-start': ['"Press Start 2P"', 'cursive']
    },
    extend: {}
  },
  plugins: []
};
