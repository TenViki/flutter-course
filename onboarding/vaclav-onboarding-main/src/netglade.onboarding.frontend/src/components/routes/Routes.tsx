import { Route, Routes } from 'react-router-dom';
import GuardedRoute from './GuardedRoute';
import Favourites from '../../pages/Favourites';
import Profile from '../../pages/Profile';
import Login from '../../pages/Login';
import Register from '../../pages/Register';
import GraphPage from '../../pages/GraphPage';
import TablePage from '../../pages/TablePage';
import Errors from '../../pages/Errors';
import { useAuthStore } from '../../store/authStore';
import AdminPage from '../../pages/AdminPage';
interface AppRoutesProp {
	/**
	 * True, if the user is authenticated, false otherwise.
	 */
	isAuthenticated: boolean;
}


const AppRoutes = (props: AppRoutesProp): JSX.Element => {
	const { isAuthenticated } = props;
	const isAdmin = useAuthStore(state => state.isAdmin);
	return (
		<Routes>
			{/* Non-Authenticated Routes: accessible only if user in not authenticated */}
			<Route
				element={
					<GuardedRoute
						isRouteAccessible={!isAuthenticated}
						redirectRoute={"/"}
					/>
				}
			>
				{/* Login Route */}
				<Route path={"/login"} Component={Login} />
			</Route>
            <Route
				element={
					<GuardedRoute
						isRouteAccessible={!isAuthenticated}
						redirectRoute={"/"}
					/>
				}
			>
				{/* Login Route */}
				<Route path={"/register"} Component={Register} />
			</Route>
			{/* Authenticated Routes */}
			<Route
				element={
					<GuardedRoute
						isRouteAccessible={isAuthenticated}
						redirectRoute={"/login"}
					/>
				}
			>
				<Route path={"/"} Component={TablePage} />
			</Route>
			<Route
				element={
					<GuardedRoute
						isRouteAccessible={isAuthenticated}
						redirectRoute={"/login"}
					/>
				}
			>
				<Route path={"/graphs"} Component={GraphPage} />
			</Route>
            <Route
				element={
					<GuardedRoute
						isRouteAccessible={isAuthenticated}
						redirectRoute={"/login"}
					/>
				}
			>
				<Route path={"/favourites"} Component={Favourites} />
			</Route>
			<Route
				element={
					<GuardedRoute
						isRouteAccessible={isAuthenticated}
						redirectRoute={"/login"}
					/>
				}
			>
				<Route path={"/errors"} Component={Errors} />
			</Route>

            <Route
				element={
					<GuardedRoute
						isRouteAccessible={isAuthenticated}
						redirectRoute={"/login"}
					/>
				}
			>
				<Route path={"/profile"} Component={Profile} />
			</Route>
			<Route
				element={
					<GuardedRoute
						isRouteAccessible={isAdmin!}
						redirectRoute={"/"}
					/>
				}
			>
				<Route path={"/admin"} Component={AdminPage} />
			</Route>

			{/* Not found Route */}
			<Route path="*" element={<p>Page Not Found</p>} />
		</Routes>
	);
};

export default AppRoutes;