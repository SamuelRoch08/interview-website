import archi from './archi.png';
import './App.css';

function getDate(){
  const today = new Date();
  const year = today.getFullYear();
  const month = today.getMonth() + 1; // january is 0
  const day = today.getDate();
  const hour = today.getHours();
  const min = today.getMinutes();

  return (year + "/" + month + "/" + day + " - " + hour + ":" + min);
}

function App() {
  return (
    <div className="App">
      <header className="App-header">  
        <p>
          Hello there ! I am built in react. 
          This is my architecture <br />
          A s3 hosting the built project in react. <br />

          The cloudfront distribution is in front of the bucket. <br />

          Access logs are put in dedicated bucket for audit. <br />

          Cache setting are tuned to 30s by default for demo, to update the website quickly. <br />
        </p>
        <img src={archi} className="App-archi" alt="archi" />
        <p>Last build on <b>{getDate()}</b></p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;
