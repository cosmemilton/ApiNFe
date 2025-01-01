import  { createContext, FC, ReactNode, useEffect, useMemo, useState } from 'react';
import PropTypes from 'prop-types';
import { IUserProps } from '../common/data/userDummyData';


export interface IAuthContextProps {
	user: string;
	setUser?(...args: unknown[]): unknown;
	userData: Partial<IUserProps>;
	setUserData?(...args: unknown[]): unknown;
}
const AuthContext = createContext<IAuthContextProps>({} as IAuthContextProps);

interface IAuthContextProviderProps {
	children: ReactNode;
}
export const AuthContextProvider: FC<IAuthContextProviderProps> = ({ children }) => {
	const [user, setUser] = useState<string>(localStorage.getItem('authUsername') || '');
	const [userData, setUserData] = useState<Partial<IUserProps>>(JSON.parse(localStorage.getItem('authUserData') || '{}'));

	useEffect(() => {
		localStorage.setItem('authUsername', user);
	}, [user]);

	useEffect(() => {
		localStorage.setItem('authUserData', JSON.stringify(userData));
	}, [userData]);

	const value = useMemo(
		() => ({
			user,
			setUser,
			userData,
			setUserData,
		}),
		[user, userData],
	);
	return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};
AuthContextProvider.propTypes = {
	children: PropTypes.node.isRequired,
};

export default AuthContext;
