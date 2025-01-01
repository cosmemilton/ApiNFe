import COLORS from './enumColors';
import { TColor } from '../../type/color-type';

export interface IEventStatus {
	[key: string]: { name: string; color: TColor };
}
const EVENT_STATUS: IEventStatus = {
	APPROVED: { name: 'Aprovado', color: COLORS.SUCCESS.name },
	PENDING: { name: 'Pendente', color: COLORS.WARNING.name },
	CANCELED: { name: 'Cancelado', color: COLORS.DANGER.name },
	REJECTED: { name: 'Rejeitado', color: COLORS.DARK.name },
	BLOCKED: { name: 'Bloqueado', color: COLORS.DANGER.name },
};
export default EVENT_STATUS;
