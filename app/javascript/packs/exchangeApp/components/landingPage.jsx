import React from 'react';
import { Segment, Divider, Header, Dropdown, Message, Icon } from 'semantic-ui-react'
import {  DateInput } from 'semantic-ui-calendar-react';
import InputNumber from 'rc-input-number';
import 'rc-input-number/assets/index.css';
import '../assets/stylesheets/app.scss'

const InputLabel = ({label}) => (
  <div className="ui label input input-label">
    <span>{label}</span>
  </div>
);

const LoadingMessage = () => (
  <Message icon>
    <Icon name='circle notched' loading />
    <Message.Content>
      <Message.Header>Just one second</Message.Header>
      We are fetching your exchange rates.
    </Message.Content>
  </Message>
)

const NoRatesMessage = () => (
  <Message warning>
    <Message.Header>No rates found</Message.Header>
    <p>Please select another date, then try again.</p>
  </Message>
)

const ErrorMessage = ({message}) => (
  <Message negative>
    <Message.Header>We're sorry we can't get any rates for you</Message.Header>
    <p>{message}</p>
  </Message>
);

const ErrorSegment = ({message}) => (
  <Segment className="exchange-app">
    <Header>Currency Converter</Header>
    <Divider clearing />
    <ErrorMessage message={error} />
  </Segment>  
);

const LoadingSegment = () => (
  <Segment className="exchange-app">
    <Header>Currency Converter</Header>
    <Divider clearing />
    <LoadingMessage />
  </Segment>  
);

const RateMessage = ({amount, converted_amount, selected_from_currency, selected_to_currency}) => {
  if(selected_to_currency === ''){
    return (<div/>);
  }

  const message = `You will get ${converted_amount} ${selected_to_currency} for ${parseFloat(amount).toFixed(2)} ${selected_from_currency}`;

  return(
    <span>{message}</span>
  );
}

const RateStatsMessage = ({from_rate, to_rate}) => {
  if(from_rate === undefined){
    return (<div/>);
  }

  const date = new Date(from_rate.date);
  const rate_date = new Date( date.getTime() - date.getTimezoneOffset() * -60000 );
  const message = `Using rates from ${rate_date.toDateString()} ${from_rate.currency} at ${from_rate.rate} to ${to_rate.currency} at ${to_rate.rate}`;

  return(
    <React.Fragment>
      <Divider clearing />
      <span>{message}</span>
    </React.Fragment>);
}

const RatesInput = ({rates, from_currency, to_currency, amount, onFromChange, onToChange}) => {

  if(rates.length === 0){
    return (<NoRatesMessage />);
  }

  const items = rates.map(rate => (
    {key: `option_${rate.currency}`, value: rate.currency, text:rate.currency }
  ));

  let selected_from_currency = '';
  let selected_to_currency = '';
  let from_rate = rates.find(rate => rate.currency === from_currency);
  let to_rate = rates.find(rate => rate.currency === to_currency);
  let converted_amount = parseFloat(amount).toFixed(2);

  if(from_rate === undefined && rates.length > 0 ){
    from_rate = rates[0];
  }

  if(to_rate === undefined && rates.length > 0 ){
    to_rate = rates[0];
  }

  if(from_rate !== undefined && to_rate !==undefined){
    selected_from_currency = from_rate.currency;  
    selected_to_currency = to_rate.currency;  
    converted_amount = ((parseFloat(amount) / from_rate.rate) * to_rate.rate).toFixed(2);
  }

  return(
    <React.Fragment>
      <div className="ui labeled input input-field">
        <InputLabel label="From:"/>
        <Dropdown
          className='currency-list'
          placeholder='Currency' 
          options={items} 
          selection 
          value={selected_from_currency}
          onChange={onFromChange}/>
      </div>
      <div className="ui labeled input input-field">
        <InputLabel label="To:"/>
        <Dropdown
          className='currency-list'
          placeholder='Currency' 
          options={items} 
          selection  
          value={selected_to_currency}
          onChange={onToChange}/>
      </div>
      <RateMessage amount={amount} converted_amount={converted_amount} selected_from_currency={selected_from_currency} selected_to_currency={selected_to_currency} />
      <RateStatsMessage from_rate={from_rate} to_rate={to_rate} />
    </React.Fragment>);
}

class LandingPage extends React.Component {
  constructor(props) {
    super(props);

    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth()+1; //January is 0!

    var yyyy = today.getFullYear();
    if(dd<10){
        dd='0'+dd;
    } 
    if(mm<10){
        mm='0'+mm;
    } 

    this.state = {
      rates: [],
      date: `${yyyy}/${mm}/${dd}`,
      amount: "1.00",
      from_currency:'',
      to_currency:'',
      error: '',
      loading: true,
    };
    this.onFromChange = this.onFromChange.bind(this);
    this.onToChange = this.onToChange.bind(this);
    this.onDateChange = this.onDateChange.bind(this);
    this.onAmountChange = this.onAmountChange.bind(this);
  }

  onFromChange(event, {value}){
    this.setState({ from_currency: value });
  }
  
  onToChange(event, {value}) {
    this.setState({ to_currency: value });
  }

  onAmountChange(value) {
    const amount = value === '' ? "1.00" : value;
    this.setState({ amount: amount });
  }

  onDateChange(event, {name, value}) {
    this.setState({ date: value });
    this.fetchData(value);
  }

  componentDidMount() {
    const { date } = this.state;
    this.fetchData(date);
  }

  fetchData(date) {
    fetch(`/api/v1/rates.json?date=${date}`)
      .then(response => {
        if (response.ok) {
          return response.json();
        } else {
          throw new Error('Something went wrong ...');
        }
      })
      .then(data => this.setState({ rates: data, loading: false }))
      .catch(error => this.setState({ error: error, loading: false}));;
  }

  render() {
    const { rates, from_currency, to_currency, amount, error, loading } = this.state;

    if(error !== ''){
      return(<ErrorSegment message={error} />);
    }

    if(loading === true){
      return(<LoadingSegment />);
    }

    return(
      <Segment className="exchange-app">
        <Header>Currency Converter</Header>
        <Divider clearing />
        <div className="ui labeled input input-field">
          <InputLabel label="When?"/>
          <DateInput
            name="date"
            placeholder="Date"
            value={this.state.date}
            iconPosition="left" 
            popupPosition="bottom right"
            dateFormat="YYYY-MM-DD"
            closable
            onChange={this.onDateChange} />
        </div>
        <div className="ui labeled input input-field">
          <InputLabel label="How much?"/>
          <InputNumber 
            precision={2}
            value={amount}
            onChange={this.onAmountChange}/>
        </div>
        <Divider clearing />
        <RatesInput rates={rates} amount={amount} from_currency={from_currency} to_currency={to_currency} onFromChange={this.onFromChange} onToChange={this.onToChange}/>  
      </Segment>
    )
  }
}

export default LandingPage