#!/usr/bin/env coffee

import '@rmw/console/global'

import MPLEX from 'libp2p-mplex'
import { NOISE } from 'libp2p-noise'
import Libp2p from 'libp2p'
import TCP from 'libp2p-tcp'

do =>
  node = await Libp2p.create({
    addresses:
      listen:['/ip4/0.0.0.0/tcp/0']
    modules:
      transport: [TCP]
      connEncryption: [NOISE]
      streamMuxer: [MPLEX]
  })
  await node.start()
  console.log "node start"
  node.multiaddrs.forEach (addr) =>
    console.log("#{addr.toString()}/p2p/#{node.peerId.toB58String()}")

  # 47.104.79.244
  # await node.stop()
  # console.log "node stop"
  if process.argv.length >= 3
    ma = multiaddr(process.argv[2])
    console.log("ping remote peer at #{ma}")
    latency = await node.ping(ma)
    console.log("pinged #{latency}ms")


  stop = =>
    await node.stop()
    console.log('libp2p has stopped')
    process.exit(0)

  process.on('SIGTERM', stop)
  process.on('SIGINT', stop)

