import express from 'express';

import * as GovernmentPeer from '../blockchain/governmentPeer';

const router = express.Router();

router.get('/', (req, res) => {
  res.render('government', { governmentActive: true });
});

router.post('/api/claims', async (req, res) => {
  try {
    const theftClaims = await GovernmentPeer.listTheftClaims();
    res.json(theftClaims || []);
  } catch (e) {
    res.json({ error: 'Error accessing blockchain.' });
  }
});

router.post('/api/process-claim', async (req, res) => {
  const { contractUuid, uuid, isTheft, fileReference } = req.body;
  if (typeof contractUuid !== 'string'
    || typeof uuid !== 'string'
    || typeof isTheft !== 'boolean'
    || typeof fileReference !== 'string') {
    res.json({ error: 'Invalid request.' });
    return;
  }

  try {
    await GovernmentPeer.processTheftClaim({
      contractUuid, uuid, isTheft, fileReference
    });
    res.json({ success: true, uuid });
  } catch (e) {
    res.json({ error: 'Error accessing blockchain.' });
  }
});

function wsConfig(io) {
  PolicePeer.on('block', block => { io.emit('block', block); });
}

export default router;
export { wsConfig };
