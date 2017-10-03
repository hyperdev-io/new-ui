React                 = require 'react'
{withState, compose}  = require 'recompose'
{ Button, Layer, Form, Header, Heading, Paragraph, FormFields, FormField, Footer, TextInput } = require 'grommet'

withName = withState 'newBucketName', 'setNewBucketName', ''

module.exports = withName ({hidden, selectedBucket, newBucketName, setNewBucketName, onClose, onSubmit}) ->
  _onDOMChange = (evt) -> setNewBucketName evt.target.value
  _onClose = -> setNewBucketName ''; onClose()
  _onSubmit = -> onSubmit?(selectedBucket, newBucketName)

  <Layer onClose={_onClose} align='right' closer={true} hidden={hidden}>
   <Form>
    <Header pad={vertical: 'medium'}><Heading>Copy</Heading></Header>
    <FormFields>
      <Paragraph>Copy the data from <strong>{selectedBucket}</strong> to a newly created bucket.</Paragraph>
      <FormField label="New bucket name">
        <TextInput autoFocus placeHolder="Copy of #{selectedBucket}"
          onDOMChange={_onDOMChange}
          onSelect={({suggestion}) -> setNewBucketName suggestion}
          value={newBucketName} />
        </FormField>
    </FormFields>
    <Footer pad={vertical:'medium'} justify='between' align='center'>
      <Button onClick={_onSubmit} primary=true label='Copy' />
      <Button onClick={_onClose} plain=true label='Cancel' />
    </Footer>
   </Form>
  </Layer>
