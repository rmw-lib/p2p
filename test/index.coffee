#!/usr/bin/env coffee
import xxx from '@rmw/xxx'
# import {xxx as Xxx} from '@rmw/xxx'
import test from 'tape-catch'

test 'xxx', (t)=>
  t.equal xxx(1,2),3
  # t.deepEqual Xxx([1],[2]),[3]
  t.end()
