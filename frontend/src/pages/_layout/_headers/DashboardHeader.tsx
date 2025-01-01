import React from 'react';
import Header, { HeaderLeft } from '../../../layout/Header/Header';
//import CommonHeaderChat from './CommonHeaderChat';
import Search from '../../../components/Search';
import CommonHeaderRight from './CommonHeaderRight';
//import User from '../../../layout/User/User'

const DashboardHeader = () => {
	return (
		<Header>
			<HeaderLeft>
				<Search />
			</HeaderLeft>
			<CommonHeaderRight  />
		</Header>
	);
};

export default DashboardHeader;
