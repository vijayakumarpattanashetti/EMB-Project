'use strict';

import { Server } from 'http';
import express from 'express';
import socketIo from 'socket.io';
import configureExpress from './config/express';
import vendorRouter, { wsConfig as vendorWsConfig }
  from './routers/vendor.router';
import governmentRouter, { wsConfig as governmentWsConfig }
  from './routers/government.router';
import hospitalRouter, { wsConfig as hospitalWsConfig }
  from './routers/hospital.router';
import insuranceRouter, { wsConfig as insuranceWsConfig }
  from './routers/insurance.router';

const INSURANCE_ROOT_URL = '/insurance';
const GOVERNMENT_ROOT_URL = '/government';
const HOSPITAL_ROOT_URL = '/hospital';
const VENDOR_ROOT_URL = '/vendor';

const app = express();
const httpServer = new Server(app);

// Setup web sockets
const io = socketIo(httpServer);
vendorWsConfig(io.of(VENDOR_ROOT_URL));
governmentWsConfig(io.of(GOVERNMENT_ROOT_URL));
hospitalWsConfig(io.of(HOSPITAL_ROOT_URL));
insuranceWsConfig(io.of(INSURANCE_ROOT_URL));

configureExpress(app);

app.get('/', (req, res) => {
  res.render('home', { homeActive: true });
});

// Setup routing
app.use(VENDOR_ROOT_URL, vendorRouter);
app.use(GOVERNMENT_ROOT_URL, governmentRouter);
app.use(HOSPITAL_ROOT_URL, hospitalRouter);
app.use(INSURANCE_ROOT_URL, insuranceRouter);

export default httpServer;
