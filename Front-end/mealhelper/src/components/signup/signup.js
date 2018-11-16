import React, { Component } from "react";
import { connect } from "react-redux";
//change the route for this
import { addUser } from "../../store/actions/userActions";
import { withRouter, Link } from "react-router-dom";
import { Alert } from "reactstrap";
import "./signup.css";

class SignUp extends Component {
	constructor(props) {
		super(props);

		this.state = {
			email: "",
			password: "",
			zip: null,
			healthCondition: "",
			visable: false
		};
	}

	handleChange = event => {
		event.preventDefault();
		this.setState({
			[event.target.name]: event.target.value
		});
	};

	createUser = event => {
		event.preventDefault();
		if (!this.state.email || !this.state.password) {
			this.setState({ visable: true });
		} else {
			const { email, password, zip, healthCondition } = this.state;
			const user = { email, password, zip, healthCondition };
			this.props.addUser(user);
			this.props.history.push("/homepage");
		}
	};

	render() {
		return (
			<div className="main-container">
				<div className="entry-button-group">
					<Link to="/signup">
						<button className="signup-button">
							<span>Signup</span>
						</button>
					</Link>
					<Link to="/login">
						<button className="login-button">
							<span>Login</span>
						</button>
					</Link>
				</div>
				<div>
				<div className="user-form-container">
					<h1 className="signup-title">Sign Up</h1>
						<form className="signup-form">
							<div className="form-group">
							<label htmlFor="dynamic-label-input">Email</label>
								<input
									id="dynamic-label-input"
									// className="email-input"
									type="text-title"
									// name="email"
									value={this.state.email}
									onChange={this.handleChange}
									placeholder="Email"
									required
								/>
							</div>
							<div className="form-group">
								<label htmlFor="dynamic-label-input">Password</label>
								<input
									id="dynamic-label-input"
									// className="password-input"
									type="password"
									// name="password"
									onChange={this.handleChange}
									value={this.state.password}
									placeholder="Password"
									required
								/>
							</div>
							<div className="form-group">
								<label htmlFor="dynamic-label-input">Zip Code</label>
								<input
									id="dynamic-label-input"
									// className="zip-input"
									type="text"
									// name="zip"
									onChange={this.handleChange}
									value={this.state.zip}
									placeholder="Zip"
								/>
							</div>
							<div className="form-group">
								<label htmlFor="dynamic-label-input">Health Condition</label>
								<input
									id="dynamic-label-input"
									// className="condition-input"
									type="text"
									// name="healthCondition"
									onChange={this.handleChange}
									value={this.state.healthCondition}
									placeholder="Health Condition"
								/>
							</div>
									{/* <div className="alert-box">
										<Alert isOpen={this.state.visable} color="danger">
											Please enter an email and address
										</Alert>
									</div> */}
								<div className="signup signup-two" onClick={this.createUser} >
									<span>Sign Up</span>
								</div>
						</form>
					</div>
				</div>
			</div>
		);
	}
}

const mapStateToProps = state => ({
	user: state.user
});

export default connect(
	mapStateToProps,
	{ addUser }
)(withRouter(SignUp));
