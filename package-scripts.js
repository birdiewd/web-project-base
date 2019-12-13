const npsUtils = require("nps-utils");
const { reduce, } = require("lodash");
const dotenv = require("dotenv");

dotenv.config();

const stringifyOptions = (options) => {
	return reduce(options, (optionString, value, key) => {
		optionString += ` --${key} ${value}`;

		return optionString;
	}, '');
}

const serveOptions = stringifyOptions({
	'target': 'browser',
	'port': process.env.PORT,
	'log-level': 4,
	'hmr-port': process.env.HMR_PORT,
});

const buildOptions = stringifyOptions({
	'target': 'browser',
});

const appEnv = 'cross-env APP_ENV';

module.exports = {
	scripts: {
		default: `nps _clear && cross-env APP_ENV=local parcel ./index.html ${serveOptions}`,

		dev: {
			default: npsUtils.series.nps(
				"_clear",
				"_build.dev",
				"_test",
				"_deploy"
			)
		},

		stage: {
			default: npsUtils.series.nps(
				"_clear", 
				"_build.stage", 
				"_test", 
				"_deploy"
			)
		},

		prod: {
			default: npsUtils.series.nps(
				"_clear",
				"_build.prod",
				"_test",
				"_deploy"
			)
		},

		_build: {
			dev: `${appEnv}=dev parcel build ./index.html ${buildOptions}`,
			stage: `${appEnv}=stage parcel build ./index.html ${buildOptions}`,
			prod: `${appEnv}=production parcel build ./index.html ${buildOptions}`,
		},

		_clear: "rm -Rf dist/*",
		_test: 'echo "we will test"',
		_deploy: 'echo "we can deploy"',

		test: {
			cypress: "cypress open"
		}
	}
};
