// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration
module.exports = {
  content: [
    './js/**/*.js',
    '../lib/fleature_web.ex',
    '../lib/fleature_web/**/*.*ex'
  ],
  theme: {
    extend: {},
  },
  plugins: [
    '@tailwindcss/forms'
  ]
}
