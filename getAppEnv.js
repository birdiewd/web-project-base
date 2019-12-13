const getAppEnv = () => {
	switch (process.env.APP_ENV) {
		case 'local':
		case 'dev':
		case 'stage':
		case 'prod':
			return process.env.APP_ENV;
			break;

		default:
			return 'local';
			break;
	}
}

export default getAppEnv;