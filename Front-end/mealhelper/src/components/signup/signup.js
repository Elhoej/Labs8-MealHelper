import React, { Component } from "react";
import { connect } from "react-redux";
//change the route for this
import { addUser } from "../actions/actions";
import { withRouter } from "react-router-dom";
import { Alert } from "reactstrap";

class Register extends Component {
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
			// this.props.history.push("/");
		}
	};

	render() {
		return (
			<div className="user-form-container">
				<form className="forms">
					<input
						className="email-input"
						type="text-title"
						name="email"
						value={this.state.email}
						onChange={this.handleChange}
						placeholder="Email"
						required
					/>
					<input
						className="password-input"
						type="password"
						name="password"
						onChange={this.handleChange}
						value={this.state.password}
						placeholder="Password"
						required
					/>
					<input
						className="zip-input"
						type="text"
						name="zip"
						onChange={this.handleChange}
						value={this.state.zip}
						placeholder="Zip"
					/>
					<input
						className="condition-input"
						type="text"
						name="healthCondition"
						onChange={this.handleChange}
						value={this.state.healthCondition}
						placeholder="Health Condition"
					/>
					<div className="alert-box">
						<Alert isOpen={this.state.visable} color="danger">
							Please enter an email and address
						</Alert>
					</div>

					<button onClick={this.createUser} className="savenote-button">
						Save
					</button>
				</form>
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
)(withRouter(Register));
