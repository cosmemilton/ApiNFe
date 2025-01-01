import  {startTransition, FC, useCallback, useContext, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import PropTypes from 'prop-types';
import classNames from 'classnames';
import PageWrapper from '../../../layout/PageWrapper/PageWrapper';
import Page from '../../../layout/Page/Page';
import Card, { CardBody } from '../../../components/bootstrap/Card';
import FormGroup from '../../../components/bootstrap/forms/FormGroup';
import Input from '../../../components/bootstrap/forms/Input';
import Button from '../../../components/bootstrap/Button';
import useDarkMode from '../../../hooks/useDarkMode';
import { useFormik } from 'formik';
import AuthContext from '../../../contexts/authContext';
import USERS, { getUserDataWithUsername } from '../../../common/data/userDummyData';
import AuthController from '../../../controllers/AuthController';

interface ILoginHeaderProps {
	isNewUser?: boolean;
}
const LoginHeader: FC<ILoginHeaderProps> = ({ isNewUser }) => {
	if (isNewUser) {
		return (
			<>
				<div className='text-center h1 fw-bold mt-5'>Create Account,</div>
				<div className='text-center h4 text-muted mb-5'>Sign up to get started!</div>
			</>
		);
	}
	return (
		<>
			<div className='text-center h1 fw-bold mt-5'>Bem Vindo,</div>
			<div className='text-center h4 text-muted mb-5'>Faça seu login para continuar...</div>
		</>
	);
};

interface ILoginProps {
	isSignUp?: boolean;
}
const Login: FC<ILoginProps> = ({ isSignUp }) => {
	const { setUser, setUserData} = useContext(AuthContext);

	const { darkModeStatus } = useDarkMode();

	const [singUpStatus, setSingUpStatus] = useState<boolean>(!!isSignUp);

	const navigate = useNavigate();
	const handleOnClick = useCallback(() => navigate('/'), [navigate]);

	const getJWT = (username: string, password: string) => {
		return AuthController.login(username, password);
	};

	const formik = useFormik({
		enableReinitialize: true,
		initialValues: {
			loginUsername: '',
			loginPassword: '',
		},
		validate: (values) => {
			const errors: { loginUsername?: string; loginPassword?: string } = {};

			if (!values.loginUsername) {
				errors.loginUsername = 'Required';
			}

			if (!values.loginPassword) {
				errors.loginPassword = 'Required';
			}

			return errors;
		},
		validateOnChange: false,
		onSubmit: (values) => {
			getJWT(values.loginUsername, values.loginPassword)
				.then((res) => {
					console.log('res', res);
					if (setUser) {
						setUser(res.name);						
					}
					if (setUserData) {
						setUserData(res);
					}
					handleOnClick();
					
				})
				.catch((error) => {
					console.log('error:',error);
					console.log('type of error:', typeof error);
					if (typeof error === 'string') {
						formik.setFieldError('loginPassword', error);
					}
					if (typeof error === 'object') {
						formik.setFieldError('loginPassword', error.message);
					}

				});			
		},
	});


	return (
		<PageWrapper
			isProtected={false}
			title={singUpStatus ? 'Sign Up' : 'Login'}
			className={classNames( 'bg-dark' )}>
			<Page className='p-0'>
				<div className='row h-100 align-items-center justify-content-center'>
					<div className='col-xl-4 col-lg-6 col-md-8 shadow-3d-container'>
						<Card className='shadow-3d-dark' data-tour='login-page'>
							<CardBody>
								<div className='text-center my-5'>
									<Link
										to='/'
										className={classNames(
											'text-decoration-none  fw-bold display-2',
											{
												'text-dark': !darkModeStatus,
												'text-light': darkModeStatus,
											},
										)}>
										
									</Link>
								</div>
								<div
									className={classNames('rounded-3', {
										'bg-l10-dark': !darkModeStatus,
										'bg-dark': darkModeStatus,
									})}>
									<div className='row row-cols-2 g-3 pb-3 px-3 mt-0'>
										<div className='col'>
											<Button
												color={darkModeStatus ? 'light' : 'dark'}
												isLight={singUpStatus}
												className='rounded-1 w-100'
												size='lg'
												onClick={() => {
													//setSignInPassword(false);
													setSingUpStatus(!singUpStatus);
												}}>
												Entrar
											</Button>
										</div>
										<div className='col'>
											<Button
												color={darkModeStatus ? 'light' : 'dark'}
												isLight={!singUpStatus}
												className='rounded-1 w-100'
												size='lg'
												onClick={() => {
													//setSignInPassword(false);
													setSingUpStatus(!singUpStatus);
												}}>
												Inscrever-se
											</Button>
										</div>										
									</div>
								</div>

								<LoginHeader isNewUser={singUpStatus} />

								<form className='row g-4'>
									{singUpStatus ? (
										<>
											<div className='col-12'>
												<FormGroup
													id='signup-email'
													isFloating
													label='Your email'>
													<Input type='email' autoComplete='email' />
												</FormGroup>
											</div>
											<div className='col-12'>
												<FormGroup
													id='signup-name'
													isFloating
													label='Your name'>
													<Input autoComplete='given-name' />
												</FormGroup>
											</div>
											<div className='col-12'>
												<FormGroup
													id='signup-surname'
													isFloating
													label='Your surname'>
													<Input autoComplete='family-name' />
												</FormGroup>
											</div>
											<div className='col-12'>
												<FormGroup
													id='signup-password'
													isFloating
													label='Password'>
													<Input
														type='password'
														autoComplete='password'
													/>
												</FormGroup>
											</div>
											<div className='col-12'>
												<Button
													color='info'
													className='w-100 py-3'
													onClick={handleOnClick}>
													Sign Up
												</Button>
											</div>
										</>
									) : (
										<>
											<div className='col-12'>
												<FormGroup
													id='loginUsername'
													isFloating
													label='E-mail ou usuário'>
													<Input
														value={formik.values.loginUsername}
														isTouched={formik.touched.loginUsername}
														invalidFeedback={
															formik.errors.loginUsername
														}
														isValid={formik.isValid}
														onChange={formik.handleChange}
														onBlur={formik.handleBlur}
														onFocus={() => {
															formik.setErrors({});
														}}
													/>
												</FormGroup>
											</div>
											<div className='col-12'>
												<FormGroup
													id='loginPassword'
													isFloating
													label='Senha'>
													<Input
														type='password'
														value={formik.values.loginPassword}
														isTouched={formik.touched.loginPassword}
														invalidFeedback={
															formik.errors.loginPassword
														}
														validFeedback='Looks good!'
														isValid={formik.isValid}
														onChange={formik.handleChange}
														onBlur={formik.handleBlur}
													/>
												</FormGroup>
											</div>
											<div className='col-12'>												
												<Button
													color='warning'
													className='w-100 py-3'
													onClick={formik.handleSubmit}>
													Entrar
												</Button>										
											</div>
										</>
									)}
									
								</form>
							</CardBody>
						</Card>
						
					</div>
				</div>
			</Page>
		</PageWrapper>
	);
};
Login.propTypes = {
	isSignUp: PropTypes.bool,
};
Login.defaultProps = {
	isSignUp: false,
};

export default Login;
