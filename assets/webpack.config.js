const path = require('path');
const glob = require('glob');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = (env, options) => ({
  optimization: {
    minimizer: [
      new TerserPlugin({ cache: true, parallel: true, sourceMap: true }),
      new OptimizeCSSAssetsPlugin({})
    ]
  },
  entry: {
    app: glob.sync('./vendor/**/*.js').concat(['./js/app.js'])
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, '../priv/static/js'),
    publicPath: '/js/'
  },
  resolve: {
    extensions: [ '.js', '.styl', '.css' ],
    alias: {
      css: path.resolve(__dirname, 'css'),
      html: path.resolve(__dirname, 'html'),
      images: path.resolve(__dirname, 'static', 'images')
    },
    modules: [
      path.resolve(__dirname, 'js'),
      'node_modules'
    ]
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
        }
      },
      {
        test: /\.(css|styl(?:us)?)$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          'stylus-loader'
        ]
      },
      // {
      //   test: /\.(ico|tiff?|png|jpe?g|pdf|woff2?|ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
      //   use: [
      //     'file-loader'
      //   ]
      // },
      {
        exclude: /\.(?:js|styl(?:us)?|css)$/,
        use: [
          'url-loader'
        ]
      }
    ]
  },
  plugins: [
    new MiniCssExtractPlugin({ filename: '../css/app.css' }),
    new CopyWebpackPlugin([{ from: 'static/', to: '../' }])
  ]
});
