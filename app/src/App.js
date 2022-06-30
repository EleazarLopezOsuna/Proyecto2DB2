import React, {useEffect, useState} from 'react';
import "./App.css"
import {Container, Form} from "react-bootstrap";
import axios from "axios";

export const App = () => {

    const [data, setData] = useState([])
    const [time, setTime] = useState(15)

    useEffect( () => {
        let interval: NodeJS.Timer
        const fetchData = async () => {
            try {
                await axios.get('http://localhost:5000')
                    .then(response => {
                        return response.data
                    })
                    .then(response => {
                        setData(response)
                    })
                    .catch(error => {
                        console.log(error)
                    })
                console.log('Peticion cada ' + time + ' minutos')
            } catch (error) {
                console.log("error", error)
            }
        }
        fetchData()
        interval = setInterval(() => {
            fetchData()
        }, time * 60000)

        return () => {
            clearInterval(interval)
        }
    }, [time])

    const handleInputChange = async (e) => {
        setTime(parseFloat(e.target.value))
    }

    return (
        <Container fluid>
            <Form.Control
                type="text"
                placeholder="Interval in Minutes, 15 Minutes by Default"
                onBlur={handleInputChange}
            />
            <div className="log-scrollable">
                <table className="log-table">
                    <thead>
                    <tr>
                        <th className="log-table-head">ID</th>
                        <th className="log-table-head">IMDB ID</th>
                        <th className="log-table-head">GENRE</th>
                        <th className="log-table-head">PRIMARY TITLE</th>
                        <th className="log-table-head">ORIGINAL TITLE</th>
                        <th className="log-table-head">IS ADULT</th>
                        <th className="log-table-head">START YEAR</th>
                        <th className="log-table-head">END YEAR</th>
                        <th className="log-table-head">RUNTIME</th>
                        <th className="log-table-head">RATING</th>
                        <th className="log-table-head">NUMBER VOTES</th>
                    </tr>
                    </thead>
                    <tbody>
                    {
                        data.map((element) => (
                            <tr>
                                <td className="log-table-cell">{element['id']}</td>
                                <td className="log-table-cell">{element['imdb_id']}</td>
                                <td className="log-table-cell">{element['genre']}</td>
                                <td className="log-table-cell">{element['primaryTitle']}</td>
                                <td className="log-table-cell">{element['originalTitle']}</td>
                                <td className="log-table-cell">{element['isAdult'].toString()}</td>
                                <td className="log-table-cell">{element['startYear']}</td>
                                <td className="log-table-cell">{element['endYear']}</td>
                                <td className="log-table-cell">{element['runtime']}</td>
                                <td className="log-table-cell">{element['rating']}</td>
                                <td className="log-table-cell">{element['numVotes']}</td>
                            </tr>
                        ))
                    }
                    </tbody>
                </table>
            </div>
        </Container>
    )
}