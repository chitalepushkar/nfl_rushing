import React, {Component} from 'react';
import './App.css';
import ServerTable from 'react-strap-table';
import Container from 'react-bootstrap/Container';
import Button from 'react-bootstrap/Button';
import Navbar from 'react-bootstrap/Navbar';
import rushingTableMapping from './rushingTableMapping'
import requestParamsMapping from './requestParamsMapping'


class App extends Component {
  constructor(props) {
    super(props);
    this.state = { downloadCSVUrl: '' };
  }

  render() {
    const url = requestParamsMapping.url;
    const columns = Object.keys(rushingTableMapping);
    const options = {
      sortable: columns,
      headings: rushingTableMapping,
      perPage: 20,
      perPageValues: [20, 30, 50, 100],
      requestParametersNames: requestParamsMapping,
      responseAdapter: (resp_data) => {
        // Setting download button with updated CSV url
        this.setState({ downloadCSVUrl: resp_data.csv_url });
        return {data: resp_data.data, total: resp_data.total}
      }
    };

    return (
      <div>
        <Navbar bg="dark" variant="dark" className="mb-20">
          <Navbar.Brand>
            NFL rushing statistics
          </Navbar.Brand>
        </Navbar>
        <Container>
          <Button className="mb-20" variant="success" size="lg" active href={this.state.downloadCSVUrl}>Download</Button>
          <ServerTable columns={columns} url={url} options={options} bordered hover/>
        </Container>
      </div>
    );
  }
}


export default App;
