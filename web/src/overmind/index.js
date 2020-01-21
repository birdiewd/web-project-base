import { createHook, } from 'overmind-react'

import { state } from "./state.js";
import * as effects from "./effects.js";
import * as actions from "./actions.js";

export const config = {
	state,
	effects,
	actions,
};

export const useOvermind = createHook();