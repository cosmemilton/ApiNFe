import dayjs from 'dayjs';
import USERS, { IUserProps } from './userDummyData';
import EVENT_STATUS, { IEventStatus } from './enumEventStatus';
import SERVICES, { IServiceProps } from './serviceDummyData';

const data: {
	id: number;
	status: IEventStatus['key'];
	date: string;
	time: number | string;
	customer: { name: string; email: string };
	assigned: IUserProps;
	service: IServiceProps;
	duration: string;
	payment: number | null;
	cnpj: string;
}[] = [
	{
		id: 1,
		status: EVENT_STATUS.APPROVED,
		date: dayjs().format('YYYY') + dayjs().format('MM') + dayjs().add(1, 'days').format('DD'),
		time: 1030,
		customer: { name: 'Alison Berry', email: 'alisonberry@site.com' },
		assigned: USERS.GRACE,
		service: SERVICES.ICE_SKATING,
		duration: '45min',
		payment: 15,
		cnpj: '10.523.963/0001-23'
	},
	{
		id: 2,
		status: EVENT_STATUS.APPROVED,
		date: dayjs().format('YYYY') + dayjs().format('MM') + dayjs().add(1, 'days').format('DD'),
		time: 1200,
		customer: { name: 'Diane Bower', email: 'dianebower@site.com' },
		assigned: USERS.JANE,
		service: SERVICES.YOGA,
		duration: '45min',
		payment: 40,
		cnpj: '82.587.362/0001-95'
	},
	{
		id: 3,
		status: EVENT_STATUS.CANCELED,
		date: dayjs().format('YYYY') + dayjs().format('MM') + dayjs().add(1, 'days').format('DD'),
		time: 1230,
		customer: { name: 'Claire Campbell', email: 'clairecampbell@site.com' },
		assigned: USERS.ELLA,
		service: SERVICES.TENNIS,
		duration: '45min',
		payment: 40,
		cnpj: '41.116.336/0001-00'
	},
	{
		id: 4,
		status: EVENT_STATUS.BLOCKED,
		date: dayjs().format('YYYY') + dayjs().format('MM') + dayjs().add(1, 'days').format('DD'),
		time: 1500,
		customer: { name: 'Sue Quinn', email: 'suequinn@site.com' },
		assigned: USERS.RYAN,
		service: SERVICES.HANDBALL,
		duration: '45min',
		payment: 120,
		cnpj: '57.478.103/0001-89'
	},
	{
		id: 5,
		status: EVENT_STATUS.APPROVED,
		date: dayjs().format('YYYY') + dayjs().format('MM') + dayjs().add(2, 'days').format('DD'),
		time: '0930',
		customer: { name: 'Gabrielle Powell', email: 'gabriellepowell@site.com' },
		assigned: USERS.ELLA,
		service: SERVICES.SNOWBOARDING,
		duration: '1h',
		payment: 45,
		cnpj: '83.986.737/0001-52'
	},
	{
		id: 6,
		status: EVENT_STATUS.REJECTED,
		date: dayjs().format('YYYY') + dayjs().format('MM') + dayjs().add(3, 'days').format('DD'),
		time: 1530,
		customer: { name: 'Emily Taylor', email: 'emilytaylor@site.com' },
		assigned: USERS.JANE,
		service: SERVICES.HANDBALL,
		duration: '45min',
		payment: null,
		cnpj: '36.483.485/0001-69'
	},
	{
		id: 7,
		status: EVENT_STATUS.PENDING,
		date: dayjs().format('YYYY') + dayjs().format('MM') + dayjs().add(3, 'days').format('DD'),
		time: 1130,
		customer: { name: 'Carolyn Morgan', email: 'carolynmorgan@site.com' },
		assigned: USERS.JANE,
		service: SERVICES.CRICKET,
		duration: '30min',
		payment: null,
		cnpj: '56.529.396/0001-13'
	},
	{
		id: 8,
		status: EVENT_STATUS.PENDING,
		date: dayjs().format('YYYY') + dayjs().format('MM') + dayjs().add(4, 'days').format('DD'),
		time: 1300,
		customer: { name: 'Penelope North', email: 'penelopenorth@site.com' },
		assigned: USERS.RYAN,
		service: SERVICES.HIKING,
		duration: '1h',
		payment: null,
		cnpj: '80.515.903/0001-44'
	},
	{
		id: 9,
		status: EVENT_STATUS.PENDING,
		date: dayjs().format('YYYY') + dayjs().format('MM') + dayjs().add(4, 'days').format('DD'),
		time: 1530,
		customer: { name: 'Alexander Kelly', email: 'alexanderkelly@site.com' },
		assigned: USERS.ELLA,
		service: SERVICES.YOGA,
		duration: '45min',
		payment: null,
		cnpj: '11.682.100/0001-50'
	},
	{
		id: 10,
		status: EVENT_STATUS.PENDING,
		date: dayjs().format('YYYY') + dayjs().format('MM') + dayjs().add(4, 'days').format('DD'),
		time: 1600,
		customer: { name: 'Cameron Hodges', email: 'cameronhodges@site.com' },
		assigned: USERS.GRACE,
		service: SERVICES.KITE_SURFING,
		duration: '30min',
		payment: null,
		cnpj: '15.853.750/0001-83'
	},
];

export default data;
