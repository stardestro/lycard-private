import React from 'react'
import Image from 'next/image'

function Navbar() {
  return (
    <div className="flex flex-row justify-between items-center">
      <Image src="/lycard.png" alt="LyCard Logo" width={72} height={16} />
    </div>
  )
}

export default Navbar